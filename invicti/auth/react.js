var input = document.querySelector('#customerNo');
var nativeInputValueSetter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, "value").set;
nativeInputValueSetter.call(input, '9999999');
var ev = new Event('input', { bubbles: true});
input.dispatchEvent(ev);

var input2 = document.querySelector('#password');
var nativeInputValueSetter2 = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, "value").set;
nativeInputValueSetter2.call(input2, '1234');
var ev2 = new Event('input', { bubbles: true});
input2.dispatchEvent(ev2);

await new Promise(r => setTimeout(r, 2000));
document.querySelector('#panel-action-button').click()

// https://blog.devgenius.io/react-tips-input-event-redux-forward-ref-and-bubbling-7824a0c3c713
