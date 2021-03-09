export default function UserLink({peerInfo, children}) {
  const {id} = peerInfo;

  return (
    <a href={`/u/${id}`}>
      {children}
    </a>
  );
}
