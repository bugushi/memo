
import Config from '../config';
import { message } from 'antd';

const API_URL = Config.API_URL;

enum ContentType {
    json = 'application/json;charset=UTF-8',
    form = 'application/x-www-form-urlencoded; charset=UTF-8'
}

type HttpMethod = 'GET' | 'POST';

interface IRequestInit {
    method?: HttpMethod;
    body?: { [key: string]: any };
    mode?: string;
    headers?: { [key: string]: any };
    searchParams?: { [key: string]: any };
}

interface responseData {
    success: boolean;
    code: string;
    message: string;
    data: object;
}

const defaultReqConfig: any = {
    headers: {
        'content-type': ContentType.json
    },
    mode: 'cors'
}

/**
 * get请求
 * @param path 带querystring 
 * @param reqConfig 
 */
export function get(path: string, reqConfig?: IRequestInit): Promise<responseData> {

    // 拼接请求地址
    let queryString = '?';
    if (reqConfig && reqConfig.searchParams) {
        for (let query in reqConfig.searchParams) {
            queryString += `${query}=${reqConfig.searchParams[query]}&`
        }
        delete reqConfig.searchParams;
    }
    queryString = queryString.slice(0, -1);
    const url = API_URL + path + queryString;

    // 额外请求参数
    const getReqConfig: RequestInit = Object.assign({}, defaultReqConfig, reqConfig, { method: 'GET' });

    return fetch(url, getReqConfig).then(res => {
        return handleResponse(res)
    })
}

/**
 * post请求
 * @param path 
 * @param reqConfig 
 */
export function post(path: string, reqConfig?: IRequestInit): Promise<responseData> {
    const postReqConfig = Object.assign({}, defaultReqConfig, reqConfig, { method: 'POST' });

    if (reqConfig && reqConfig.headers) {
        let headers: any = Object.assign({}, defaultReqConfig.headers, reqConfig.headers);
        postReqConfig.headers = headers;

        if (headers["content-type"] === ContentType.json && postReqConfig.body) {
            postReqConfig.body = JSON.stringify(postReqConfig.body);
        } else if (headers["content-type"] === ContentType.form && postReqConfig.body) {
            postReqConfig.body = serialize(postReqConfig.body);
        }
    }

    postReqConfig.searchParams && delete postReqConfig.searchParams;


    const url = API_URL + path;
    const finalPostReqConfig: RequestInit = postReqConfig;

    return fetch(url, finalPostReqConfig).then(res => {
        return handleResponse(res)
    })
}

/**
 * 处理返回结果
 * @param res http response
 */
function handleResponse(res: Response): Promise<responseData> {
    if (!res.ok) {
        message.error('请求失败');
        throw res;
    }

    return res.json().then(data => {
        if (data && data.code === '2000') {
            return Promise.resolve(data);
        } else {
            return Promise.reject(data);
        }
    }).catch(err => {
        message.error('解析失败');
        throw err;
    })
}

/**
 * 序列化
 * @param obj 
 */
function serialize(obj: { [key: string]: any }): string {
    var str = [];
    for (var key in obj) {
        if (obj.hasOwnProperty(key)) {
            str.push(encodeURIComponent(key) + "=" + encodeURIComponent(obj[key]))
        }
    }
    return str.join("&");
}
