/* 
================================================================================
檔案代號:inpl_t
檔案名稱:週期盤點明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inpl_t
(
inplent       number(5)      ,/* 企業編號 */
inplsite       varchar2(10)      ,/* 營運據點 */
inpldocno       varchar2(20)      ,/* 標籤編號 */
inplseq       number(10,0)      ,/* 項次 */
inpl001       varchar2(40)      ,/* 料件編號 */
inpl002       varchar2(256)      ,/* 產品特徵 */
inpl003       varchar2(30)      ,/* 庫存管理特徵 */
inpl004       varchar2(10)      ,/* 包裝容器編號 */
inpl005       varchar2(10)      ,/* 庫位編號 */
inpl006       varchar2(10)      ,/* 儲位編號 */
inpl007       varchar2(30)      ,/* 批號 */
inpl008       varchar2(20)      ,/* 盤點計劃單號 */
inpl009       varchar2(10)      ,/* 庫存單位 */
inpl010       number(20,6)      ,/* 現有庫存量 */
inpl011       varchar2(10)      ,/* 參考單位 */
inpl012       number(20,6)      ,/* 參考單位現有庫存量 */
inpl013       varchar2(10)      ,/* 理由碼 */
inpl014       varchar2(255)      ,/* 備註 */
inpl030       number(20,6)      ,/* 盤點數量-初盤 */
inpl031       number(20,6)      ,/* 參考單位盤點量-初盤 */
inpl032       varchar2(20)      ,/* 盤點人員-初盤 */
inpl033       date      ,/* 盤點日期-初盤 */
inpl050       number(20,6)      ,/* 盤點數量-複盤 */
inpl051       number(20,6)      ,/* 參考單位盤點量-複盤 */
inpl052       varchar2(20)      ,/* 盤點人員-複盤 */
inpl053       date      ,/* 盤點日期-複盤 */
inplud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inplud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inplud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inplud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inplud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inplud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inplud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inplud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inplud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inplud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inplud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inplud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inplud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inplud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inplud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inplud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inplud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inplud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inplud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inplud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inplud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inplud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inplud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inplud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inplud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inplud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inplud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inplud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inplud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inplud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpl_t add constraint inpl_pk primary key (inplent,inplsite,inpldocno,inplseq) enable validate;

create unique index inpl_pk on inpl_t (inplent,inplsite,inpldocno,inplseq);

grant select on inpl_t to tiptop;
grant update on inpl_t to tiptop;
grant delete on inpl_t to tiptop;
grant insert on inpl_t to tiptop;

exit;
