export default function FeedPost({post}) {
  return (
    <div>
      {post.content}

      {post.images.map((image, i) => {
        return (
          <div key={i}>
            <img src={image.url} alt="" className="h-32 w-32"/>
          </div>
        );
      })}
    </div>
  );
}
