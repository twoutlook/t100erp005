/* 
================================================================================
檔案代號:glfd_t
檔案名稱:財務指標公式設定維護單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glfd_t
(
glfdent       number(5)      ,/* 企業編號 */
glfdownid       varchar2(20)      ,/* 資料所有者 */
glfdowndp       varchar2(10)      ,/* 資料所屬部門 */
glfdcrtid       varchar2(20)      ,/* 資料建立者 */
glfdcrtdp       varchar2(10)      ,/* 資料建立部門 */
glfdcrtdt       timestamp(0)      ,/* 資料創建日 */
glfdmodid       varchar2(20)      ,/* 資料修改者 */
glfdmoddt       timestamp(0)      ,/* 最近修改日 */
glfdstus       varchar2(10)      ,/* 狀態碼 */
glfd001       varchar2(10)      ,/* 報表結構編號 */
glfd002       varchar2(5)      ,/* 會計科目參照表號 */
glfdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glfdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glfdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glfdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glfdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glfdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glfdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glfdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glfdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glfdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glfdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glfdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glfdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glfdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glfdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glfdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glfdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glfdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glfdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glfdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glfdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glfdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glfdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glfdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glfdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glfdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glfdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glfdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glfdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glfdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glfd_t add constraint glfd_pk primary key (glfdent,glfd001) enable validate;

create unique index glfd_pk on glfd_t (glfdent,glfd001);

grant select on glfd_t to tiptop;
grant update on glfd_t to tiptop;
grant delete on glfd_t to tiptop;
grant insert on glfd_t to tiptop;

exit;
