export default function PostCommentsCount({post}) {
  const commentsCount = post.commentsCount.get();

  if (commentsCount < 1) return null;

  return (
    <div>
      {commentsCount} comments
    </div>
  );
}
