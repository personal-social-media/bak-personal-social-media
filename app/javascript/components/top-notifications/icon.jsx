import {counterStyle} from './icon.module.scss';

export default function TopNotificationsIcon() {
  return (
    <div className="relative cursor-pointer h-12 w-12 border-gray-300 border border-solid rounded-full flex justify-center items-center hover:bg-gray-100">
      <div className="text-indigo-700">
        <i className="fa fa-bell fa-2x"/>
      </div>

      <div className={`absolute text-indigo-700 bg-white rounded-full w-8 h-8 flex justify-center items-center shadow-lg select-none text-xs ${counterStyle}`}>
        44+
      </div>
    </div>
  );
}
