// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* Count the number of characters in a micropost. */
function countCharacters(textField, charCountLabel, maxLength) {
  var currentLength = textField.value.length;
  if (currentLength > maxLength) {
    // Trim the text, if it exceeds max length.
    textField.value = textField.value.substring(0, maxLength);
  } else {
    // Update characters remaining counter label.
    charCountLabel.innerHTML = maxLength - currentLength;
  }
}