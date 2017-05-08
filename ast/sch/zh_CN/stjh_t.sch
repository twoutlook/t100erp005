/* 
================================================================================
檔案代號:stjh_t
檔案名稱:招商租賃合約優惠費用單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stjh_t
(
stjhent       number(5)      ,/* 企業編號 */
stjhsite       varchar2(10)      ,/* 營運組織 */
stjhunit       varchar2(10)      ,/* 制定組織 */
stjhseq       number(10,0)      ,/* 項次 */
stjh001       varchar2(20)      ,/* 合約編號 */
stjh002       varchar2(10)      ,/* 費用編號 */
stjh003       varchar2(20)      ,/* 優惠單號 */
stjh004       date      ,/* 開始日期 */
stjh005       date      ,/* 截止日期 */
stjh006       number(20,6)      ,/* 費用金額 */
stjh007       varchar2(10)      ,/* 合約版本 */
stjh008       varchar2(10)      ,/* 優惠類型 */
stjhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stjhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stjhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stjhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stjhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stjhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stjhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stjhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stjhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stjhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stjhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stjhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stjhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stjhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stjhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stjhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stjhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stjhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stjhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stjhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stjhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stjhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stjhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stjhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stjhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stjhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stjhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stjhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stjhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stjhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stjh_t add constraint stjh_pk primary key (stjhent,stjhseq,stjh001) enable validate;

create unique index stjh_pk on stjh_t (stjhent,stjhseq,stjh001);

grant select on stjh_t to tiptop;
grant update on stjh_t to tiptop;
grant delete on stjh_t to tiptop;
grant insert on stjh_t to tiptop;

exit;
