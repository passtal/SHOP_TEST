/**
 *  유효성 검사 
 */
function checkProduct() {
	let form = document.product
	let productId = form.productId
	let name = form.name
	let unitPrice = form.unitPrice
	let unitsInStock = form.unitsInStock
	
	let msg = ''
	
	// 상품아이디 체크
	// - P숫자 6자리 (예: P123456)
	let productIdCheck = /^P[0-9]{6}$/
	msg = '상품 아이디는 "알파벳 P에 숫자 6자리" 로 입력해주세요' 
	if( !check(productIdCheck, productId, msg) ) return false
	
	// 상품명 체크
	// - 2글자 이상 20글자 이하
	let nameCheck = /^.{2,20}$/
	msg = '상품명은 2~20자 이내로 입력해주세요'
	if( !check(nameCheck, name, msg) ) return false
	
	// 가격 체크
	// - 숫자로 1글자 이상 (음수 방지 및 숫자만 허용)
	let priceCheck = /^[0-9]+$/
	msg = '가격은 1글자 이상의 숫자로 입력해주세요'
	if( !check(priceCheck, unitPrice, msg) ) return false
	
	// 재고 체크
	// - 숫자로 1글자 이상
	let stockCheck = /^[0-9]+$/
	msg = '재고는 1글자 이상의 숫자로 입력해주세요'
	if( !check(stockCheck, unitsInStock, msg) ) return false
	
	return true
}

// 정규표현식 유효성 검사 함수
function check(regExp, element, msg) {
	
	if( regExp.test(element.value) ) {
		return true
	}
	alert(msg)
	element.select()
	element.focus()
	return false
}