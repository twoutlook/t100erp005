/* 
================================================================================
檔案代號:inpm_t
檔案名稱:週期盤點單製作批序號明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inpm_t
(
inpment       number(5)      ,/* 企業編號 */
inpmsite       varchar2(10)      ,/* 營運據點 */
inpmdocno       varchar2(20)      ,/* 盤點編號 */
inpmseq       number(10,0)      ,/* 項次 */
inpmseq1       number(10,0)      ,/* 序號 */
inpm001       varchar2(40)      ,/* 料件編號 */
inpm002       varchar2(256)      ,/* 產品特徵 */
inpm003       varchar2(30)      ,/* 庫存管理特徵 */
inpm004       varchar2(40)      ,/* 包裝容器編號 */
inpm005       varchar2(10)      ,/* 庫位 */
inpm006       varchar2(10)      ,/* 儲位 */
inpm007       varchar2(30)      ,/* 批號 */
inpm008       varchar2(30)      ,/* 製造批號 */
inpm009       varchar2(30)      ,/* 製造序號 */
inpm010       date      ,/* 製造日期 */
inpm011       date      ,/* 有效日期 */
inpm012       number(20,6)      ,/* 現有庫存量 */
inpm030       number(20,6)      ,/* 盤點數量-初盤 */
inpm031       varchar2(20)      ,/* 輸入人員-初盤 */
inpm032       date      ,/* 輸入日期-初盤 */
inpm033       varchar2(20)      ,/* 盤點人員-初盤 */
inpm034       date      ,/* 盤點日期-初盤 */
inpm050       number(20,6)      ,/* 盤點數量-複盤 */
inpm051       varchar2(20)      ,/* 輸入人員-複盤 */
inpm052       date      ,/* 輸入日期-複盤 */
inpm053       varchar2(20)      ,/* 盤點人員-複盤 */
inpm054       date      ,/* 盤點日期-複盤 */
inpmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpm_t add constraint inpm_pk primary key (inpment,inpmsite,inpmdocno,inpmseq,inpmseq1) enable validate;

create unique index inpm_pk on inpm_t (inpment,inpmsite,inpmdocno,inpmseq,inpmseq1);

grant select on inpm_t to tiptop;
grant update on inpm_t to tiptop;
grant delete on inpm_t to tiptop;
grant insert on inpm_t to tiptop;

exit;
