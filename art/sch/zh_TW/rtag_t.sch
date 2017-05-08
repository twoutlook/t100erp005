/* 
================================================================================
檔案代號:rtag_t
檔案名稱:品類策略異動申請明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtag_t
(
rtagent       number(5)      ,/* 企業編號 */
rtagdocno       varchar2(20)      ,/* 單據編號 */
rtag001       varchar2(10)      ,/* 策略編號 */
rtag002       varchar2(10)      ,/* 品類編號 */
rtag003       varchar2(10)      ,/* 角色編號 */
rtag004       number(20,6)      ,/* SKU占比 */
rtag005       number(15,3)      ,/* SKU上限 */
rtag006       number(15,3)      ,/* SKU下限 */
rtag007       number(20,6)      ,/* 毛利率上限 */
rtag008       number(20,6)      ,/* 毛利率下限 */
rtagacti       varchar2(1)      ,/* 資料有效碼 */
rtagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtag_t add constraint rtag_pk primary key (rtagent,rtagdocno,rtag002) enable validate;

create unique index rtag_pk on rtag_t (rtagent,rtagdocno,rtag002);

grant select on rtag_t to tiptop;
grant update on rtag_t to tiptop;
grant delete on rtag_t to tiptop;
grant insert on rtag_t to tiptop;

exit;
