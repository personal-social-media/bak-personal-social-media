export default function Static({value}) {
  return (
    <div>
      <button className="pure-button" onClick={(e) => e.preventDefault()}>
        <span className="capitalize">
          {value}
        </span>
      </button>
    </div>
  );
}
