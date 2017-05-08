/* 
================================================================================
檔案代號:mhad_t
檔案名稱:場地基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table mhad_t
(
mhadent       number(5)      ,/* 企業編號 */
mhadsite       varchar2(10)      ,/* 營運據點 */
mhadunit       varchar2(10)      ,/* 應用組織 */
mhad001       varchar2(10)      ,/* 樓棟編號 */
mhad002       varchar2(10)      ,/* 樓層編號 */
mhad003       varchar2(10)      ,/* 區域編號 */
mhad004       varchar2(10)      ,/* 場地編號 */
mhad005       number(20,6)      ,/* 建築面積 */
mhad006       number(20,6)      ,/* 測量面積 */
mhad007       number(20,6)      ,/* 經營面積 */
mhad008       varchar2(10)      ,/* 場地使用狀態 */
mhadstus       varchar2(10)      ,/* 狀態碼 */
mhadownid       varchar2(20)      ,/* 資料所有者 */
mhadowndp       varchar2(10)      ,/* 資料所屬部門 */
mhadcrtid       varchar2(20)      ,/* 資料建立者 */
mhadcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhadcrtdt       timestamp(0)      ,/* 資料創建日 */
mhadmodid       varchar2(20)      ,/* 資料修改者 */
mhadmoddt       timestamp(0)      ,/* 最近修改日 */
mhadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mhadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mhadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mhadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mhadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mhadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mhadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mhadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mhadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mhadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mhadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mhadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mhadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mhadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mhadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mhadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mhadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mhadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mhadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mhadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mhadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mhadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mhadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mhadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mhadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mhadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mhadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mhadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mhadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mhadud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mhad009       number(10,0)      /* 版本 */
);
alter table mhad_t add constraint mhad_pk primary key (mhadent,mhad001,mhad002,mhad003,mhad004) enable validate;

create unique index mhad_pk on mhad_t (mhadent,mhad001,mhad002,mhad003,mhad004);

grant select on mhad_t to tiptop;
grant update on mhad_t to tiptop;
grant delete on mhad_t to tiptop;
grant insert on mhad_t to tiptop;

exit;
