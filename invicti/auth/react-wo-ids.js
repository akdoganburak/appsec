await new Promise(r => setTimeout(r, 2000));
var input = document.querySelector("[name='tckn']");
var nativeInputValueSetter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, "value").set;
nativeInputValueSetter.call(input, '9999999');
var ev = new Event('input', { bubbles: true});
input.dispatchEvent(ev);

var input2 = document.querySelector("[name='password']");
var nativeInputValueSetter2 = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, "value").set;
nativeInputValueSetter2.call(input2, '1234');
var ev2 = new Event('input', { bubbles: true});
input2.dispatchEvent(ev2);

await new Promise(r => setTimeout(r, 1000));
document.querySelector('.ykb-ui-button').click()
