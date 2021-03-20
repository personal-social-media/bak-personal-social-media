export default function ReactionButton({children, saveReaction, reactionType}) {
  function createReaction(e, reactionType) {
    e.preventDefault();
    saveReaction(reactionType);
  }

  return (
    <button onClick={(e) => createReaction(e, reactionType)}>
      {children}
    </button>
  );
}
