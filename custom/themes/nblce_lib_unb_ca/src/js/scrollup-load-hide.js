window.addEventListener('load', function () {
  const button = document.querySelector('.scrollup');
  if (button && window.scrollY === 0) {
    button.style.display = 'none';
  }
});