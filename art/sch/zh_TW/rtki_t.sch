/* 
================================================================================
檔案代號:rtki_t
檔案名稱:自動補貨補貨模型品類參數明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtki_t
(
rtkient       number(5)      ,/* 企業編號 */
rtkiunit       varchar2(10)      ,/* 應用組織 */
rtki001       varchar2(10)      ,/* 補貨模型編號 */
rtki002       varchar2(10)      ,/* 品類編號 */
rtki003       number(15,3)      ,/* 安全庫存天數 */
rtki004       number(15,3)      ,/* 最小庫存天數 */
rtki005       number(20,6)      ,/* DMS預設值 */
rtki006       number(20,6)      ,/* 促銷PDMS預設值 */
rtki007       number(20,6)      ,/* 門店備貨週期校正系數 */
rtkiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtkiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtkiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtkiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtkiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtkiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtkiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtkiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtkiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtkiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtkiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtkiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtkiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtkiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtkiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtkiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtkiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtkiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtkiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtkiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtkiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtkiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtkiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtkiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtkiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtkiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtkiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtkiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtkiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtkiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtki_t add constraint rtki_pk primary key (rtkient,rtki001,rtki002) enable validate;

create unique index rtki_pk on rtki_t (rtkient,rtki001,rtki002);

grant select on rtki_t to tiptop;
grant update on rtki_t to tiptop;
grant delete on rtki_t to tiptop;
grant insert on rtki_t to tiptop;

exit;
