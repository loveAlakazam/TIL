const arr = [1, 2, 3, 4, 5];

const sum = arr.filter((e: number) => e % 2 === 1).map((e: number) => e * 2);
console.log(sum);
