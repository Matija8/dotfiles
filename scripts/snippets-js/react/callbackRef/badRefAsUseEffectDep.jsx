// https://codesandbox.io/s/bad-example-ref-does-not-handle-unmount-nrk28
import React, { useEffect, useReducer, useRef, useState } from 'react';
import ReactDOM from 'react-dom';

const Component = () => {
  const ref = useRef();

  const [isMounted, toggle] = useReducer((p) => !p, true);
  const [elementRect, setElementRect] = useState();

  useEffect(() => {
    console.log(ref.current);
    setElementRect(ref.current?.getBoundingClientRect());
  }, [ref.current]);

  return (
    <>
      {isMounted && <div ref={ref}>Example</div>}
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
