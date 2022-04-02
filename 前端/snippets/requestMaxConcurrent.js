function request(urls, max, callback) {
    let results = [];
    const setResult = (value, listener) => {
        results.push(value);
        if (results.length == urls.length) {
            callback(results);
        } else {
            listener(urls[results.length]);
        }
    }

    const fetchWithAction = (url) => {
        fetch(url).then(value => {
            setResult(value, fetchWithAction)
        })
    }

    for (let i = 0; i < max; i++) {
        if (urls[i]) {
            fetchWithAction(urls[i]);
        }
    }
}