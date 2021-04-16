import FadeIn from 'react-fade-in';
import SearchListItem from '../list-item';

export default function SearchListResultsFound({state}) {
  return (
    <>
      {
        state.localSearches.length > 0 &&
        <div style={{minHeight: '5rem'}}>
          <div className="text-gray-700 text-sm">
            Known peers:
          </div>

          {
            <FadeIn className="local-searches-list">
              {state.localSearches.map((identity) => {
                return (
                  <div key={identity.id.get()} className="my-2">
                    <SearchListItem identity={identity} displayName={identity.name.get()} link={`/u/${identity.id.get()}`} storeState={state}/>
                  </div>
                );
              })}
            </FadeIn>
          }
        </div>
      }

      {
        state.registrySearches.length > 0 &&
        <div style={{minHeight: '5rem'}}>
          <div className="text-gray-700 text-sm">
            Registry peers:
          </div>

          <FadeIn className="registry-searches-list">
            {state.registrySearches.map((identity) => {
              return (
                <div key={identity.publicKey.get()} className="my-2">
                  <SearchListItem identity={identity} displayName={`@${identity.username.get()}`} storeState={state}/>
                </div>
              );
            })}
          </FadeIn>
        </div>
      }
    </>
  );
}
