export default function SelfFriendShip() {
  function open() {
    window.Turbolinks.visit('/sessions/profile');
  }
  return (
    <div>
      <button className="pure-button bg-white hover:bg-white border-solid border-gray-400 border" onClick={open}>Edit profile</button>
    </div>
  );
}
