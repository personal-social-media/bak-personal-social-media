import {TopSearchInput} from './top-search/input';
import {useRef} from 'react';
import PreviousSearchesList from './top-search/previous-searches-list';
import SearchList from './top-search/list';

export default function TopSearch() {
  const inputRef = useRef();

  return (
    <div>
      <TopSearchInput ref={inputRef}/>
      <SearchList inputRef={inputRef}/>
      <PreviousSearchesList inputRef={inputRef}/>
    </div>
  );
}
