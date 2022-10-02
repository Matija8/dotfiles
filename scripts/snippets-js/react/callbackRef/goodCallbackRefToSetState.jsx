// https://codesandbox.io/s/good-example-handle-the-node-directly-pkvno
import React, { useCallback, useReducer, useState } from 'react';
import ReactDOM from 'react-dom';

const Component = () => {
  const [isMounted, toggle] = useReducer((p) => !p, true);
  const [elementRect, setElementRect] = useState();

  const handleRect = useCallback((node) => {
    setElementRect(node?.getBoundingClientRect());
  }, []);

  return (
    <>
      {isMounted && <div ref={handleRect}>Example</div>}
      <button onClick={toggle}>Toggle</button>
      <pre>{JSON.stringify(elementRect, null, 2)}</pre>
    </>
  );
};

const rootElement = document.getElementById('root');
ReactDOM.render(
  <React.StrictMode>
    <Component />
  </React.StrictMode>,
  rootElement,
);
