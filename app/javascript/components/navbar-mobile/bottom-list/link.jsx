export default function BottomListLink({icon, url}) {
  return (
    <a href={url}>
      <div className="text-center text-gray-700 hover:text-gray-900">
        <i className={icon}/>
      </div>
    </a>
  );
}
