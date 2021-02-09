export default function ExtraActionsAccepted() {
  function open() {
    window.Turbolinks.visit('/sessions/settings');
  }

  return (
    <div>
      <i className="fa fa-ellipsis-v fa-2x cursor-pointer" onClick={open}/>
    </div>
  );
}
