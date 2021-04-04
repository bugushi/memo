let arr = [
    [0, 4, 0, 0, 0, 0, 0, 1, 0],
    [7, 0, 0, 0, 6, 0, 0, 9, 0],
    [0, 0, 0, 9, 0, 0, 8, 0, 0],
    [0, 0, 8, 2, 0, 1, 0, 0, 6],
    [0, 7, 0, 0, 4, 0, 0, 5, 0],
    [3, 0, 0, 7, 0, 6, 4, 0, 0],
    [0, 0, 9, 0, 0, 2, 0, 0, 0],
    [0, 5, 0, 0, 8, 0, 0, 0, 2],
    [0, 1, 0, 0, 0, 0, 0, 3, 0],
]

let finished = false;
while (!finished) {
    finished = compute(arr);
    console.log(finished);
}

function compute(arr) {
    let finished = false;
    outer: for (let i = 0; i < 9; i++) {
        for (let j = 0; j < 9; j++) {
            if (i === 8 && j === 8 && arr[i][j] !== 0) {
                finished = true;
                console.log(JSON.stringify(arr));
            }
            if (arr[i][j] === 0) {
                let p = getP(arr, i, j);
                if (p.length === 1) {
                    arr[i][j] = p[0];
                    break outer;
                }
            }
        }
    }
    return finished;
}

function getP(arr, rowIndex, colIndex) {
    let pInRow = getPInRow(arr, rowIndex);
    let pInCol = getPInCol(arr, colIndex);
    let pInSection = getPInSection(arr, rowIndex, colIndex);

    let p = pInRow.filter(val => pInCol.includes(val)).filter(val => pInSection.includes(val));
    console.log(`row = ${rowIndex}, col = ${colIndex}, p = ${JSON.stringify(p)}`);
    return p;
}

function getPInRow(arr, rowIndex) {
    let p = [];
    let row = arr[rowIndex];
    for (let i = 1; i < 10; i++) {
        if (!row.includes(i)) {
            p.push(i);
        }
    }
    console.log('p in row: ', JSON.stringify(p));
    return p;
}

function getPInCol(arr, colIndex) {
    let p = [];
    let col = [];
    for (let i = 0; i < 9; i++) {
        col.push(arr[i][colIndex]);
    }
    for (let i = 1; i < 10; i++) {
        if (!col.includes(i)) {
            p.push(i);
        }
    }
    console.log('p in col: ', JSON.stringify(p));
    return p;
}

function getPInSection(arr, rowIndex, colIndex) {
    let p = [];
    let section = [];
    let sectionRowIndex = Math.floor(rowIndex / 3);
    let sectionColIndex = Math.floor(colIndex / 3);
    for (let i = sectionRowIndex * 3; i < sectionRowIndex * 3 + 3; i++) {
        for (let j = sectionColIndex * 3; j < sectionColIndex * 3 + 3; j++) {
            section.push(arr[i][j]);
        }
    }

    for (let i = 1; i < 10; i++) {
        if (!section.includes(i)) {
            p.push(i);
        }
    }
    console.log('p in section: ', JSON.stringify(p));
    return p;
}
