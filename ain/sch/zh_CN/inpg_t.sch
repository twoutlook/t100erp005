/* 
================================================================================
檔案代號:inpg_t
檔案名稱:在製工單盤點明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inpg_t
(
inpgent       number(5)      ,/* 企業編號 */
inpgsite       varchar2(10)      ,/* 營運據點 */
inpgdocno       varchar2(20)      ,/* 標籤編號 */
inpgseq       number(10,0)      ,/* 項次 */
inpgseq1       number(10,0)      ,/* 項序 */
inpgseq2       number(10,0)      ,/* 序號 */
inpg001       varchar2(40)      ,/* 發料料號 */
inpg002       varchar2(10)      ,/* 作業編號 */
inpg003       varchar2(10)      ,/* 制程序 */
inpg004       number(20,6)      ,/* 標準QPA */
inpg005       number(20,6)      ,/* 實際QPA */
inpg006       number(20,6)      ,/* 應發數量 */
inpg007       varchar2(10)      ,/* 單位 */
inpg008       number(20,6)      ,/* 已發數量 */
inpg009       number(20,6)      ,/* 報廢數量 */
inpg010       varchar2(30)      ,/* 庫存管理特徵 */
inpg011       number(20,6)      ,/* 超領數量 */
inpg012       number(20,6)      ,/* 應盤數量 */
inpg013       varchar2(10)      ,/* 理由碼 */
inpg014       varchar2(255)      ,/* 備註 */
inpg030       number(20,6)      ,/* 盤點數量-初盤(一) */
inpg031       varchar2(20)      ,/* 盤點人員-初盤(一) */
inpg032       date      ,/* 盤點日期-初盤(一) */
inpg033       number(20,6)      ,/* 盤點數量-初盤(二) */
inpg034       varchar2(20)      ,/* 盤點人員-初盤(二) */
inpg035       date      ,/* 盤點日期-初盤(二) */
inpg050       number(20,6)      ,/* 盤點數量-複盤(一) */
inpg051       varchar2(20)      ,/* 盤點人員-複盤(一) */
inpg052       date      ,/* 盤點日期-複盤(一) */
inpg053       number(20,6)      ,/* 盤點數量-複盤(二) */
inpg054       varchar2(20)      ,/* 盤點人員-複盤(二) */
inpg055       date      ,/* 盤點日期-複盤(二) */
inpgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpgud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
inpg015       varchar2(256)      /* 產品特徵 */
);
alter table inpg_t add constraint inpg_pk primary key (inpgent,inpgsite,inpgdocno,inpgseq,inpgseq1,inpgseq2) enable validate;

create unique index inpg_pk on inpg_t (inpgent,inpgsite,inpgdocno,inpgseq,inpgseq1,inpgseq2);

grant select on inpg_t to tiptop;
grant update on inpg_t to tiptop;
grant delete on inpg_t to tiptop;
grant insert on inpg_t to tiptop;

exit;
