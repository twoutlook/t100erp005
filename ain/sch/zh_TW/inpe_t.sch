/* 
================================================================================
檔案代號:inpe_t
檔案名稱:盤點單製造批序號明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inpe_t
(
inpeent       number(5)      ,/* 企業編號 */
inpesite       varchar2(10)      ,/* 營運據點 */
inpedocno       varchar2(20)      ,/* 盤點編號 */
inpeseq       number(10,0)      ,/* 項次 */
inpeseq2       number(10,0)      ,/* 序號 */
inpe001       varchar2(40)      ,/* 料件編號 */
inpe002       varchar2(256)      ,/* 產品特徵 */
inpe003       varchar2(30)      ,/* 庫存管理特徵 */
inpe004       varchar2(40)      ,/* 包裝容器編號 */
inpe005       varchar2(10)      ,/* 庫位 */
inpe006       varchar2(10)      ,/* 儲位 */
inpe007       varchar2(30)      ,/* 批號 */
inpe008       varchar2(30)      ,/* 製造批號 */
inpe009       varchar2(30)      ,/* 製造序號 */
inpe010       date      ,/* 製造日期 */
inpe011       date      ,/* 有效日期 */
inpe012       number(20,6)      ,/* 現有庫存量 */
inpe030       number(20,6)      ,/* 盤點數量-初盤(一) */
inpe031       varchar2(20)      ,/* 輸入人員-初盤(一) */
inpe032       date      ,/* 輸入日期-初盤(一) */
inpe033       varchar2(20)      ,/* 盤點人員-初盤(一) */
inpe034       date      ,/* 盤點日期-初盤(一) */
inpe035       number(20,6)      ,/* 盤點數量-初盤(二) */
inpe036       varchar2(20)      ,/* 輸入人員-初盤(二) */
inpe037       date      ,/* 輸入日期-初盤(二) */
inpe038       varchar2(20)      ,/* 盤點人員-初盤(二) */
inpe039       date      ,/* 盤點日期-初盤(二) */
inpe050       number(20,6)      ,/* 盤點數量-複盤(一) */
inpe051       varchar2(20)      ,/* 輸入人員-複盤(一) */
inpe052       date      ,/* 輸入日期-複盤(一) */
inpe053       varchar2(20)      ,/* 盤點人員-複盤(一) */
inpe054       date      ,/* 盤點日期-複盤(一) */
inpe055       number(20,6)      ,/* 盤點數量-複盤(二) */
inpe056       varchar2(20)      ,/* 輸入人員-複盤(二) */
inpe057       date      ,/* 輸入日期-複盤(二) */
inpe058       varchar2(20)      ,/* 盤點人員-複盤(二) */
inpe059       date      ,/* 盤點日期-複盤(二) */
inpeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpe_t add constraint inpe_pk primary key (inpeent,inpesite,inpedocno,inpeseq,inpeseq2) enable validate;

create unique index inpe_pk on inpe_t (inpeent,inpesite,inpedocno,inpeseq,inpeseq2);

grant select on inpe_t to tiptop;
grant update on inpe_t to tiptop;
grant delete on inpe_t to tiptop;
grant insert on inpe_t to tiptop;

exit;
