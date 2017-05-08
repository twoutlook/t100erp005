/* 
================================================================================
檔案代號:dzdc_t
檔案名稱:元件關鍵詞檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdc_t
(
dzdcstus       varchar2(10)      ,/* 狀態碼 */
dzdc001       varchar2(40)      ,/* 元件代號 */
dzdc002       number(10,0)      ,/* 關鍵字序號 */
dzdc003       number(10)      ,/* 識別碼版次 */
dzdc004       varchar2(1)      ,/* 使用標示 */
dzdcownid       varchar2(20)      ,/* 資料所有者 */
dzdcowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdccrtid       varchar2(20)      ,/* 資料建立者 */
dzdccrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdccrtdt       timestamp(0)      ,/* 資料創建日 */
dzdcmodid       varchar2(20)      ,/* 資料修改者 */
dzdcmoddt       timestamp(0)      ,/* 最近修改日 */
dzdccnfid       varchar2(20)      ,/* 資料確認者 */
dzdccnfdt       timestamp(0)      ,/* 資料確認日 */
dzdc005       varchar2(40)      /* 客戶代號 */
);
alter table dzdc_t add constraint dzdc_pk primary key (dzdc001,dzdc002,dzdc003,dzdc004) enable validate;

create unique index dzdc_pk on dzdc_t (dzdc001,dzdc002,dzdc003,dzdc004);

grant select on dzdc_t to tiptop;
grant update on dzdc_t to tiptop;
grant delete on dzdc_t to tiptop;
grant insert on dzdc_t to tiptop;

exit;
