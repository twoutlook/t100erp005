/* 
================================================================================
檔案代號:pjbw_t
檔案名稱:專案活動變更歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbw_t
(
pjbwent       number(5)      ,/* 企業編號 */
pjbw001       varchar2(20)      ,/* 專案編號 */
pjbw002       varchar2(30)      ,/* 活動編號 */
pjbw003       varchar2(10)      ,/* 主要欄位二 */
pjbw004       number(10,0)      ,/* 變更序 */
pjbw005       varchar2(20)      ,/* 變更欄位 */
pjbw006       varchar2(10)      ,/* 變更類型 */
pjbw007       varchar2(255)      ,/* 變更前內容 */
pjbw008       varchar2(255)      ,/* 變更後內容 */
pjbw009       varchar2(80)      ,/* 最後變更時間 */
pjbw010       varchar2(500)      ,/* 欄位說明SQL */
pjbwownid       varchar2(20)      ,/* 資料所有者 */
pjbwowndp       varchar2(10)      ,/* 資料所有部門 */
pjbwcrtid       varchar2(20)      ,/* 資料建立者 */
pjbwcrtdp       varchar2(10)      ,/* 資料建立部門 */
pjbwcrtdt       timestamp(0)      ,/* 資料創建日 */
pjbwmodid       varchar2(20)      ,/* 資料修改者 */
pjbwmoddt       timestamp(0)      ,/* 最近修改日 */
pjbwcnfid       varchar2(20)      ,/* 資料確認者 */
pjbwcnfdt       timestamp(0)      ,/* 資料確認日 */
pjbwpstid       varchar2(20)      ,/* 資料過帳者 */
pjbwpstdt       timestamp(0)      ,/* 資料過賬日 */
pjbwstus       varchar2(10)      ,/* 狀態碼 */
pjbwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pjbw_t add constraint pjbw_pk primary key (pjbwent,pjbw001,pjbw002,pjbw003,pjbw004,pjbw005) enable validate;

create unique index pjbw_pk on pjbw_t (pjbwent,pjbw001,pjbw002,pjbw003,pjbw004,pjbw005);

grant select on pjbw_t to tiptop;
grant update on pjbw_t to tiptop;
grant delete on pjbw_t to tiptop;
grant insert on pjbw_t to tiptop;

exit;
