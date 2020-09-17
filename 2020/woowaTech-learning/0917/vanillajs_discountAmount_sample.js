const discountAmount = (price, discount) => {
  return price * discount;
};

const discAmount = (price) => (discount) => {
  return price * discount;
};

console.log(discountAmount(50000, 0.5));

// 함수의 이름을 다양하게 할 수 있다.
const summerPrice = discAmount(0.5);
console.log(summerPrice(50000));
