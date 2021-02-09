export default function ExtraActionsSelf() {
  function open() {
    window.Turbolinks.visit('/sessions/settings');
  }

  return (
    <div>
      <i className="fa fa-cog fa-2x cursor-pointer" onClick={open}/>
    </div>
  );
}
