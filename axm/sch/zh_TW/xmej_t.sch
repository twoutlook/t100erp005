/* 
================================================================================
檔案代號:xmej_t
檔案名稱:訂單變更多交期匯總檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmej_t
(
xmejent       number(5)      ,/* 企業編號 */
xmejsite       varchar2(10)      ,/* 營運據點 */
xmejdocno       varchar2(20)      ,/* 訂單單號 */
xmejseq       number(10,0)      ,/* 訂單項次 */
xmejseq2       number(10,0)      ,/* 分批序 */
xmej002       number(20,6)      ,/* 分批數量 */
xmej003       date      ,/* 約定交貨日期 */
xmej004       date      ,/* 預計簽收日 */
xmej005       varchar2(10)      ,/* 出貨時段 */
xmej006       varchar2(1)      ,/* MRP凍結否 */
xmej900       number(10,0)      ,/* 變更序 */
xmej901       varchar2(1)      ,/* 變更類型 */
xmej200       varchar2(10)      ,/* 庫區/庫位 */
xmej201       varchar2(10)      ,/* 儲位 */
xmej202       varchar2(30)      ,/* 批號 */
xmejunit       varchar2(10)      ,/* 應用組織 */
xmejud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmejud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmejud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmejud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmejud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmejud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmejud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmejud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmejud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmejud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmejud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmejud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmejud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmejud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmejud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmejud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmejud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmejud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmejud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmejud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmejud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmejud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmejud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmejud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmejud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmejud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmejud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmejud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmejud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmejud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmej007       varchar2(10)      /* 交期類型 */
);
alter table xmej_t add constraint xmej_pk primary key (xmejent,xmejdocno,xmejseq,xmejseq2,xmej900) enable validate;

create unique index xmej_pk on xmej_t (xmejent,xmejdocno,xmejseq,xmejseq2,xmej900);

grant select on xmej_t to tiptop;
grant update on xmej_t to tiptop;
grant delete on xmej_t to tiptop;
grant insert on xmej_t to tiptop;

exit;
