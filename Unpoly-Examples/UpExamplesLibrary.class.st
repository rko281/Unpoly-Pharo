Class {
	#name : 'UpExamplesLibrary',
	#superclass : 'SBSFileLibrary',
	#category : 'Unpoly-Examples',
	#package : 'Unpoly-Examples'
}

{ #category : 'public' }
UpExamplesLibrary >> cssunpolyexamplesCss [

	^ WAFileLibraryResource
		filepath: 'css/unpoly.examples.css'
		mimeType: (WAMimeType main: 'text' sub: 'css')
		cacheDuration: (Duration days: 0 hours: 0 minutes: 0 seconds: 10)
		contents: (GRDelayedSend receiver: self selector: #cssunpolyexamplesCssContent)
]

{ #category : 'public' }
UpExamplesLibrary >> cssunpolyexamplesCssContent [

	^'
 :root {
	 --bs-font-sans-serif: ''Roboto'', sans-serif;
	 --bs-font-monospace: ''Roboto Mono'', monospace;
}
 a {
	 --bs-link-decoration: none;
}
 .navbar {
	 --bs-navbar-padding-x: 1rem;
}
.up-current {
	 color: #000;
}
 body {
	 margin: 5.5rem 1.5rem 7rem 1.5rem;
	 overflow-y: scroll;
}
 .container {
	 max-width: 1100px;
}
 p {
	 margin-bottom: 0.8rem;
}
 b, strong, th {
	 font-weight: 500;
}
 .field_with_errors {
	 display: contents;
}
 .input-group .field_with_errors {
	 display: inline-block;
	 flex: 1 1 auto;
}
 .field_with_errors:not(form.up-active .field_with_errors) label {
	 color: #dc3545;
}
 .field_with_errors:not(form.up-active .field_with_errors) input,.field_with_errors:not(form.up-active .field_with_errors) textarea,.field_with_errors:not(form.up-active .field_with_errors) select {
	 border-color: #dc3545;
}
 .form-error:not(form.up-active .form-error) {
	 color: #dc3545;
}
 .form-group {
	 margin-bottom: 1rem;
}
 .btn {
	 text-align: center;
}
 .btn.btn-sm {
	 min-width: 50px;
}
 .btn:not(.btn-sm) {
	 min-width: 75px;
}
 up-popup {
	 z-index: 1070;
}
 up-popup.tour-hint {
	 margin: 12px;
}
 up-popup.tour-hint code {
	 white-space: nowrap;
}
 up-popup-content {
	 line-height: 1.3;
}
 up-popup-content p {
	 margin-bottom: 0.7rem;
}
 up-popup-content :not(.popup-spinner):last-child {
	 margin-bottom: 0;
}
 up-modal-box {
	 padding: 1.8rem 2rem;
}
 up-modal-content :last-child {
	 margin-bottom: 0;
}
 up-modal-content > *:last-child {
	 margin-bottom: 0;
}
 #tasks {
	 max-width: 650px;
	 margin: 0 auto;
}
 .task {
	 position: relative;
	 display: flex;
	 align-items: center;
	 gap: 1rem;
	 border: 1px solid #dee2e6;
	 padding: 0.5rem 1rem;
}
 .task:first-child {
	 border-top-left-radius: 0.375rem;
	 border-top-right-radius: 0.375rem;
}
 .task:last-child {
	 border-bottom-left-radius: 0.375rem;
	 border-bottom-right-radius: 0.375rem;
}
 .task + .task {
	 border-top: none;
}
 .task-item.-done .task-item--text {
	 text-decoration: line-through;
}
 .task-item.-done .task-item--toggle:after {
	 content: ''✔'';
	 position: absolute;
	 width: 100%;
	 height: 100%;
	 font-size: 1.2em;
	 line-height: 1.3em;
	 text-align: center;
}
 .task-item.-previewing {
	 color: #6c757d;
}
 .task-item[draggable=true] {
	 cursor: move;
}
 .task-item--toggle {
	 flex: 0 0 auto;
	 width: 1.5em;
	 height: 1.5em;
	 display: inline-block;
	 border-radius: 4em;
	 border: 1px solid #adb5bd;
	 position: relative;
}
 .task-item--text {
	 flex: 1 1 0;
	 padding: 0.375rem 0;
}
 .task-item--edit {
	 flex: 0 0 auto;
}
 .task-item.-dragging {
	 cursor: move;
	 cursor: -webkit-grabbing;
	 cursor: -moz-grabbing;
}
 .task.-dropping {
	 border-bottom-color: #0d6efd !important;
	 border-bottom-width: 3px;
	 margin-bottom: -2px;
}
 .task-form {
	 gap: 0;
	 display: grid;
	 grid-template-columns: 1fr auto;
	 grid-template-rows: auto;
	 grid-template-areas: "input save" "error error";
	 align-items: center;
	 column-gap: 1rem;
}
 .task-form:focus {
	 outline: none !important;
}
 .task-form--input {
	 grid-area: input;
}
 .task-form--input:focus {
	 box-shadow: none !important;
}
 .task-form--save {
	 grid-area: save;
}
 .task-form--error {
	 margin-top: 0.25rem;
	 grid-area: error;
}
 .fragment-explainer {
	 background-color: white;
	 padding: 0.95rem 1.2rem 1rem;
	 position: fixed;
	 z-index: 2500;
	 bottom: 0;
	 left: 0;
	 width: 100vw;
	 border-top: 1px solid #adb5bd;
	 box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.1);
	 display: flex;
	 gap: 0.6rem 1.7rem;
	 flex-wrap: wrap;
	 line-height: 1.35;
	 justify-content: flex-start;
	 align-items: center;
}
 .fragment-explainer--cell {
	 flex: 0 1 auto;
	 min-width: calc(min(100px, 13vw));
}
 .fragment-explainer--cell a {
	 text-decoration: underline;
}
 .fragment-explainer--label {
	 margin-bottom: 4px;
	 font-size: 0.8em;
	 font-weight: 500;
	 text-transform: uppercase;
	 color: #444;
}
 #config {
	 display: grid;
	 grid-template-columns: auto auto auto;
	 column-gap: 1em;
}
 .new-fragment {
	 position: relative;
}
 .new-fragment:after {
	 transition: all 750ms ease-out;
	 content: '''';
	 position: absolute;
	 left: 0;
	 top: 0;
	 right: 0;
	 bottom: 0;
	 background-color: rgba(255, 204, 34, 0);
	 outline: 10px solid rgba(255, 204, 34, 0);
	 z-index: 1;
}
 .new-fragment.inserted:after {
	 background-color: rgba(255, 204, 34, 0.6);
	 outline: 10px solid rgba(255, 204, 34, 0.6);
}
 .click-bubble {
	 box-sizing: border-box;
	 position: fixed;
	 border-style: solid;
	 border-color: #f29;
	 border-radius: 50%;
	 animation: click-bubble 0.3s ease-out;
	 z-index: 999999;
}
 @keyframes click-bubble {
	 0% {
		 opacity: 0.8;
		 width: 0.5em;
		 height: 0.5em;
		 margin: -0.25em;
		 border-width: 0.5em;
	}
	 100% {
		 opacity: 0.1;
		 width: 6em;
		 height: 6em;
		 margin: -3em;
		 border-width: 0.2em;
	}
}
 .tour-dot {
	 margin: 0 0.4rem;
	 display: inline-block;
	 vertical-align: middle;
	 width: 10px;
	 height: 10px;
	 border-radius: 50%;
	 background: #0f0;
	 cursor: pointer;
	 box-shadow: 0 0 0 4px rgba(0, 255, 0, 0.3);
	 font-size: 0;
}
 .tour-dot:hover {
	 animation: none;
}
 .tour-dot[overlay-only] {
	 display: none;
}
 up-modal .tour-dot[overlay-only], up-drawer .tour-dot[overlay-only] {
	 display: inline-block;
}
 .tour-dot.viewed {
	 animation: none;
	 filter: grayscale(100%);
	 opacity: 0.6;
}
 #new-version {
	 position: fixed;
	 top: 0.75rem;
	 right: 1rem;
	 z-index: 1050;
}
 [up-flashes], .flashes-explainer {
	 position: fixed;
	 top: 0.4rem;
	 right: 1rem;
	 z-index: 1050;
}
 [up-flashes] .alert, .flashes-explainer .alert {
	 padding: 0.5rem 0.7rem;
	 margin: 0;
}
 .flashes-explainer {
	 padding: 0.5rem 0.7rem;
	 border: 1px solid rgba(0, 0, 0, 0.1);
	 color: #666;
	 border-radius: 0.25rem;
}
 #new-version:not([hidden]) + .flashes-explainer {
	 display: none;
}
 .placeholder {
	 opacity: 0.1;
	 border-radius: 15px;
}
 .btn-spinner {
	 display: inline-block;
	 vertical-align: middle;
	 width: 1em;
	 aspect-ratio: 1;
	 position: relative;
	 margin-top: -0.15em;
}
 .btn-spinner:after {
	 content: '''';
	 position: absolute;
	 left: 0;
	 top: 0;
	 right: 0;
	 bottom: 0;
	 border: 2px solid rgba(255, 255, 255, 1.0);
	 border-bottom-color: rgba(255, 255, 255, 0.2);
	 border-radius: 50%;
	 box-sizing: border-box;
	 animation: rotation 1s linear infinite;
	 opacity: inherit;
}
 .btn:has(.btn-spinner) {
	 text-align: center;
}
 .popup-spinner {
	 display: inline-block;
	 vertical-align: middle;
	 width: 2.5rem;
	 aspect-ratio: 1;
	 position: relative;
	 margin: 0.5rem 3rem 6rem 0.5rem;
}
 .popup-spinner:after {
	 content: '''';
	 position: absolute;
	 left: 0;
	 top: 0;
	 right: 0;
	 bottom: 0;
	 border: 2px solid rgba(13, 202, 240, 1.0);
	 border-bottom-color: rgba(13, 202, 240, 0.2);
	 border-radius: 50%;
	 box-sizing: border-box;
	 animation: rotation 1s linear infinite;
	 opacity: inherit;
}
 .main-spinner {
	 display: inline-block;
	 vertical-align: middle;
	 width: 6rem;
	 aspect-ratio: 1;
	 position: relative;
	 position: absolute;
	 top: 50%;
	 left: 50%;
	 transform: translate(-50%, -50%);
}
 .main-spinner:after {
	 content: '''';
	 position: absolute;
	 left: 0;
	 top: 0;
	 right: 0;
	 bottom: 0;
	 border: 3px solid rgba(13, 202, 240, 1.0);
	 border-bottom-color: rgba(13, 202, 240, 0.2);
	 border-radius: 50%;
	 box-sizing: border-box;
	 animation: rotation 1s linear infinite;
	 opacity: inherit;
	 transition: opacity 0.3s ease-in;
	 opacity: 1;
}
 @starting-style {
    .main-spinner:after {
        opacity: 0.1
    }
}

 main:has(>.main-spinner) {
    position: relative;
    opacity: 1;
    filter: grayscale(0%)
}

 main:has(>.main-spinner)>*:not(.main-spinner) {
    transition: opacity 0.3s ease-out, filter 0.3s ease-out;
    opacity: 0.4;
    filter: grayscale(100%)
}
 .placeholder-wave {
	 transition: opacity 0.2s ease-in;
	 opacity: 1;
}
 @starting-style {
	 opacity: 0.5;
}
 @keyframes rotation {
	 0% {
		 transform: rotate(0deg);
	}
	 100% {
		 transform: rotate(360deg);
	}
}
 input[type=search].up-active {
	 background-image: repeating-linear-gradient(-45deg, transparent, transparent 1rem, rgba(200, 230, 255, 0.3) 1rem, rgba(200, 230, 255, 0.3) 2rem);
	 background-size: 2000% 2000%;
	 animation: barberpole 200s linear infinite;
}
 @keyframes barberpole {
	 100% {
		 background-position: -1000% 1000%;
	}
}
 '
]

{ #category : 'public' }
UpExamplesLibrary >> jsunpolyexamplesJs [

	^ WAFileLibraryResource
		filepath: 'js/unpoly.examples.js'
		mimeType: (WAMimeType main: 'application' sub: 'javascript')
		cacheDuration: (Duration days: 0 hours: 0 minutes: 30 seconds: 0)
		contents: (GRDelayedSend receiver: self selector: #jsunpolyexamplesJsContent)
]

{ #category : 'public' }
UpExamplesLibrary >> jsunpolyexamplesJsContent [

^'// Unpoly //////////////////////////////////////////////////////////////////////////////////////////////////////////////

//= require unpoly
//= require unpoly-bootstrap5

// Accelerate all links so the demo feels snappy.
// We still assign out [up-follow] manually so there''s less magic for demo viewers.
up.link.config.instantSelectors.unshift(''a[href]'')
up.link.config.preloadSelectors.unshift(''a[href]'')

// We use a .form-group to contain each (label, input, error, help) tuple.
// Unpoly can use this to only update the affected a group when validating.
up.form.config.groupSelectors.unshift(''.form-group'')

// Since we''re rendering instant loading state for all interactions in the demo,
// wait longer until we show the progress bar.
up.network.config.lateTime = 1250

// Enable more logging for curious users.
up.log.enable()


// Tour /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Gray out tour dots once clicked.
up.on(''up:link:follow'', ''.tour-dot'', (event, element) => { element.classList.add(''viewed'') })


// Fragment explainer //////////////////////////////////////////////////////////////////////////////////////////////////

up.compiler(''.fragment-explainer'', function(container) {
  let lastFragment = document.documentElement

  let targetExplainer = container.querySelector(''.fragment-explainer--target'')
  let revealTarget = container.querySelector(''.fragment-explainer--reveal'')
  let requestExplainer = container.querySelector(''.fragment-explainer--request'')
  let rttExplainer = container.querySelector(''.fragment-explainer--rtt'')

  return [
    up.on(''up:fragment:inserted'', (_event, fragment) => {
      if (fragment.matches(''[up-hungry]'')) return
      if (fragment.querySelector(''.placeholder'')) return
      if (fragment.matches(''up-modal, up-modal main, up-drawer, up-drawer main, up-popup, up-popup main'')) fragment = up.layer.current.getBoxElement()
      lastFragment = fragment
      targetExplainer.innerText = up.fragment.toTarget(fragment, { verify: false })
      if (config.showFragments.checked) showInsertedFlash(lastFragment)
    }),

    up.on(revealTarget, ''click'', (event) => {
      up.event.halt(event)
      showInsertedFlash(lastFragment)
    }),

    up.on(''up:link:follow up:form:submit'', ({ renderOptions }) => {
      let method = up.util.normalizeMethod(renderOptions.method)
      requestExplainer.innerText = `${method} ${renderOptions.url}`
    }),

    up.on(''up:fragment:loaded'', ({ request, response, revalidating }) => {
      if (revalidating) return

      let rtt = Math.max(response.loadedAt - request.builtAt, 0)
      let info = `${rtt} ms`
      if (request.fromCache) {
        info += '' <span class="text-muted">(cache)</span>''
      }
      rttExplainer.innerHTML = info
    })
  ]
})

up.compiler(''form#config'', function(form) {
  return [
    up.on(''up:link:follow up:form:submit'', function(event) {
      if (form.disableCache.checked) {
        event.renderOptions.cache = false
      }
      if (form.noPreviews.checked) {
        Object.assign(event.renderOptions, up.RenderOptions.NO_PREVIEWS)
      }
      if (form.noMotion.checked) {
        Object.assign(event.renderOptions, up.RenderOptions.NO_MOTION)
      }
    }),

    up.on(''up:link:preload'', (event) => {
      if (form.disableCache.checked) {
        event.preventDefault()
      }
    }),

    up.on(''up:request:load'', ({ request }) => {
      if (form.extraLatency.checked) {
        request.headers[''X-Extra-Latency''] = ''true''
      }
    }),

    up.on(''up:click'', { capture: true }, (event) => {
      if (form.showClicks.checked) {
        let style = {
          top: event.clientY + "px",
          left: event.clientX + "px"
        }
        let bubble = up.element.affix(document.body, ''.click-bubble'', { style })
        bubble.addEventListener(''animationend'', () => bubble.remove());
      }
    })
  ]
})

function showInsertedFlash(fragment) {
  fragment = up.fragment.get(fragment)
  fragment.classList.add(''new-fragment'', ''inserted'')
  up.util.timer(0, () => fragment.classList.remove(''inserted''))
  up.util.timer(750, () => fragment.classList.remove(''new-fragment''))
}


// Notifications ///////////////////////////////////////////////////////////////////////////////////////////////////////

// Prompt user to reload when frontend assets changeds on the server.
up.on(''up:assets:changed'', function() {
  up.element.show(document.querySelector(''#new-version''))
})

// Remove notification flashes after a few seconds.
up.compiler(''.alert'', function(alert) {
  up.util.timer(4000, () => up.destroy(alert, { animation: ''move-to-top'' }))
})


// Loading state ///////////////////////////////////////////////////////////////////////////////////////////////////////

function findButton(origin) {
  if (origin.matches(''.btn'')) {
    return origin
  } else {
    let form = origin.closest(''form'')
    return up.form.submitButtons(form)[0]
  }
}

// Show a spinning wheel inside the button.
up.preview(''btn-spinner'', function(preview) {
  let button = findButton(preview.origin)
  // Keep the button dimensions while we''re hiding its content.
  preview.setStyle(button, { height: button.offsetHeight + ''px'', width: button.offsetWidth + ''px'' })
  preview.swapContent(button, ''<span class="btn-spinner"></span>'')
})

// Show a spinning wheel inside a loading popup overlay
up.preview(''popup-spinner'', function(preview) {
  preview.showPlaceholder(''<div class="popup-spinner"></div>'')
})

// Show a spinning wheel inside a loading main element
up.preview(''main-spinner'', function(preview) {
  let main = up.fragment.closest(preview.fragment, '':main'')
  preview.insert(main, ''afterbegin'', ''<div class="main-spinner"></div>'')
})

// Shorten placeholder table to the maximum number of rows given
up.compiler(''.placeholder-wave'', function(placeholder, { rows = 15 }) {
  let trs = placeholder.querySelectorAll(''tr'')
  for (let i = 0; i < trs.length - rows; i++) {
    trs[i].remove()
  }
})


// Templates with simple {{variable}} substitution /////////////////////////////////////////////////////////////////////

up.on(''up:template:clone'', ''[type="text/minimustache"]'', function(event) {
  let template = event.target.innerHTML
  let filled = template.replace(/{{(\w+)}}/g, (_match, variable) => up.util.escapeHTML(event.data[variable]))
  event.nodes = up.element.createNodesFromHTML(filled)
})


// Tasks ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Setting a `-done` class will line-through the task text.
up.preview(''finish-task'', function(preview) {
  preview.addClass(''-done'')
})

// Removing a `-done` class will remove the line-through decoration from the task text.
up.preview(''unfinish-task'', function(preview) {
  preview.removeClass(''-done'')
})

up.preview(''add-task'', function(preview) {
  let form = preview.origin.closest(''form'')
  let text = preview.params.get(''task[text]'')
  let newItem = up.template.clone(''#task-preview'', { text })
  preview.insert(form, ''afterend'', newItem)
  form.reset()
})

up.preview(''clear-tasks'', function(preview) {
  let doneTasks = up.fragment.all(''.task.-done'')
  for (let doneTask of doneTasks) {
    preview.hide(doneTask)
  }
})

up.compiler(''#tasks'', function(container) {
  let draggingItem

  up.on(container, ''dragstart'', ''.task-item'', function(event, item) {
    draggingItem = item
    item.classList.add(''-dragging'')
  })

  up.on(container, ''dragover'', ''.task'', function(event, item) {
    event.preventDefault() // prime drop event
    item.classList.add(''-dropping'')
  })

  up.on(container, ''dragleave'', ''.task'', function(event, item) {
    item.classList.remove(''-dropping'')
  })

  up.on(container, ''drop'', ''.task'', function(event, dropItem) {
    if (!draggingItem) return
    event.preventDefault()

    draggingItem.classList.remove(''-dragging'')
    dropItem.classList.remove(''-dropping'')

    if (draggingItem !== dropItem) {
      up.render({
        target: ''#tasks'',
        method: ''patch'',
        url: `/tasks/${draggingItem.dataset.id}/move`,
        params: { reference: dropItem.dataset.id },
        fallback: true,
        preview: (preview) => preview.insert(dropItem, ''afterend'', draggingItem)
      })
    }
  })

})
'
]

{ #category : 'accessing' }
UpExamplesLibrary >> selectorsToInclude [

	^#(#cssunpolyexamplesCss #jsunpolyexamplesJs)
]
