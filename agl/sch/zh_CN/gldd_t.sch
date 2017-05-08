/* 
================================================================================
檔案代號:gldd_t
檔案名稱:合併組織股本異動單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gldd_t
(
glddent       number(5)      ,/* 企業編號 */
gldddocno       varchar2(20)      ,/* 單據編號 */
gldddocdt       date      ,/* 單據日期 */
glddld       varchar2(5)      ,/* 合併帳套 */
gldd001       varchar2(10)      ,/* 上層公司 */
gldd002       varchar2(5)      ,/* 帳套(上層公司) */
glddownid       varchar2(20)      ,/* 資料所有者 */
glddowndp       varchar2(10)      ,/* 資料所屬部門 */
glddcrtid       varchar2(20)      ,/* 資料建立者 */
glddcrtdp       varchar2(10)      ,/* 資料建立部門 */
glddcrtdt       timestamp(0)      ,/* 資料創建日 */
glddmodid       varchar2(20)      ,/* 資料修改者 */
glddmoddt       timestamp(0)      ,/* 最近修改日 */
glddcnfid       varchar2(20)      ,/* 資料確認者 */
glddcnfdt       timestamp(0)      ,/* 資料確認日 */
glddpstid       varchar2(20)      ,/* 資料過帳者 */
glddpstdt       timestamp(0)      ,/* 資料過帳日 */
glddstus       varchar2(10)      ,/* 狀態碼 */
glddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glddud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldd_t add constraint gldd_pk primary key (glddent,gldddocno) enable validate;

create unique index gldd_pk on gldd_t (glddent,gldddocno);

grant select on gldd_t to tiptop;
grant update on gldd_t to tiptop;
grant delete on gldd_t to tiptop;
grant insert on gldd_t to tiptop;

exit;
