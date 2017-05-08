/* 
================================================================================
檔案代號:xmdw_t
檔案名稱:銷售合約結算歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdw_t
(
xmdwent       number(5)      ,/* 企業編號 */
xmdwsite       varchar2(10)      ,/* 營運據點 */
xmdw001       varchar2(20)      ,/* 合約單號 */
xmdw002       number(10,0)      ,/* 項次 */
xmdw003       timestamp(0)      ,/* 結算日期 */
xmdw004       number(20,6)      ,/* 本期新增數量 */
xmdw005       number(20,6)      ,/* 本期新增未稅金額 */
xmdw006       number(20,6)      ,/* 本期新增含稅金額 */
xmdw007       number(20,6)      ,/* 本期新增稅額 */
xmdw008       number(20,6)      ,/* 本期累積數量 */
xmdw009       number(20,6)      ,/* 本期累積未稅金額 */
xmdw010       number(20,6)      ,/* 本期累積含稅金額 */
xmdw011       number(20,6)      ,/* 本期累積稅額 */
xmdw012       varchar2(20)      ,/* 結算人員 */
xmdw013       varchar2(10)      ,/* 結算部門 */
xmdwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmdw_t add constraint xmdw_pk primary key (xmdwent,xmdw001,xmdw002,xmdw003) enable validate;

create unique index xmdw_pk on xmdw_t (xmdwent,xmdw001,xmdw002,xmdw003);

grant select on xmdw_t to tiptop;
grant update on xmdw_t to tiptop;
grant delete on xmdw_t to tiptop;
grant insert on xmdw_t to tiptop;

exit;
