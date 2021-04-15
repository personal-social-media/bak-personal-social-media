export default function TopListLink({children, url, className}) {
  return (
    <a href={url} className={className}>
      <div>
        {children}
      </div>
    </a>
  );
}
