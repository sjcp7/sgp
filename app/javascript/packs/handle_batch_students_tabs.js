function handleTabClick(e) {
  console.log(e)
  document.querySelector('.is-active').className = ''
  e.target.className = 'is-active'
}

panelTabs = document.querySelectorAll('.panel-tabs a')
panelTabs.forEach(tab => {
  tab.addEventListener('click', handleTabClick)
})