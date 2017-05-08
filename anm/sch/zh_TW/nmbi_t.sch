/* 
================================================================================
檔案代號:nmbi_t
檔案名稱:資金計劃主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:Y
============.========================.==========================================
 */
create table nmbi_t
(
nmbient       number(5)      ,/* 企業編號 */
nmbidocno       varchar2(20)      ,/* 資金計劃單號 */
nmbidocdt       date      ,/* 錄入日期 */
nmbi001       varchar2(10)      ,/* 編製計劃單位 */
nmbi002       varchar2(10)      ,/* 組織版本 */
nmbi003       varchar2(10)      ,/* 收支項目版本 */
nmbi004       varchar2(1)      ,/* 金額單位 */
nmbi005       varchar2(20)      ,/* 審核人員 */
nmbi006       date      ,/* 審核日期 */
nmbi007       number(5,0)      ,/* 版本 */
nmbistus       varchar2(1)      ,/* 狀態碼 */
nmbiownid       varchar2(20)      ,/* 資料所有者 */
nmbiowndp       varchar2(10)      ,/* 資料所屬部門 */
nmbicrtid       varchar2(20)      ,/* 資料建立者 */
nmbicrtdp       varchar2(10)      ,/* 資料建立部門 */
nmbicrtdt       timestamp(0)      ,/* 資料創建日 */
nmbimodid       varchar2(20)      ,/* 資料修改者 */
nmbimoddt       timestamp(0)      ,/* 最近修改日 */
nmbicnfid       varchar2(20)      ,/* 資料確認者 */
nmbicnfdt       timestamp(0)      ,/* 資料確認日 */
nmbiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbi_t add constraint nmbi_pk primary key (nmbient,nmbidocno) enable validate;

create unique index nmbi_pk on nmbi_t (nmbient,nmbidocno);

grant select on nmbi_t to tiptop;
grant update on nmbi_t to tiptop;
grant delete on nmbi_t to tiptop;
grant insert on nmbi_t to tiptop;

exit;
