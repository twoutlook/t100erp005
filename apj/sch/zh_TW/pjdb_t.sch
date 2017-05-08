/* 
================================================================================
檔案代號:pjdb_t
檔案名稱:項目進度報告單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjdb_t
(
pjdbent       number(5)      ,/* 企業編號 */
pjdbsite       varchar2(10)      ,/* 營運據點 */
pjdbdocno       varchar2(20)      ,/* 單據單號 */
pjdbseq       number(10,0)      ,/* 項次 */
pjdb001       varchar2(20)      ,/* 專案編號 */
pjdb002       varchar2(10)      ,/* 客戶編號 */
pjdb003       varchar2(10)      ,/* 收款條件 */
pjdb004       varchar2(10)      ,/* 交易條件 */
pjdb005       varchar2(10)      ,/* 幣別 */
pjdb006       number(20,10)      ,/* 匯率 */
pjdb007       varchar2(10)      ,/* 稅別 */
pjdb008       varchar2(1)      ,/* 含稅否 */
pjdb009       number(5,2)      ,/* 稅率 */
pjdb010       number(20,6)      ,/* 合同未稅金額 */
pjdb011       number(20,6)      ,/* 合同含稅金額 */
pjdb012       number(20,6)      ,/* 歷史進度% */
pjdb013       number(20,6)      ,/* 當前進度% */
pjdb014       number(20,6)      ,/* 本期進度% */
pjdb015       number(20,6)      ,/* 本期未稅金額 */
pjdb016       number(20,6)      ,/* 本期含稅金額 */
pjdb017       varchar2(10)      ,/* no use */
pjdb018       number(20,6)      ,/* no use */
pjdb019       number(20,6)      ,/* no use */
pjdb020       number(20,6)      ,/* no use */
pjdb021       number(20,6)      ,/* no use */
pjdb022       number(20,6)      ,/* no use */
pjdb023       number(20,6)      ,/* no use */
pjdb024       number(20,6)      ,/* no use */
pjdb025       number(20,6)      ,/* no use */
pjdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjdbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjdb026       number(20,6)      ,/* 項目預估成本-材料 */
pjdb027       number(20,6)      ,/* 項目預估成本-人工 */
pjdb028       number(20,6)      ,/* 項目預估成本-加工费 */
pjdb029       number(20,6)      ,/* 項目預估成本-制费一 */
pjdb030       number(20,6)      ,/* 項目預估成本-制费二 */
pjdb031       number(20,6)      ,/* 項目預估成本-制费三 */
pjdb032       number(20,6)      ,/* 項目預估成本-制费四 */
pjdb033       number(20,6)      ,/* 項目預估成本-制费五 */
pjdb034       number(20,6)      ,/* 前期累計成本-材料 */
pjdb035       number(20,6)      ,/* 前期累計成本-人工 */
pjdb036       number(20,6)      ,/* 前期累計成本-加工费 */
pjdb037       number(20,6)      ,/* 前期累計成本-制费一 */
pjdb038       number(20,6)      ,/* 前期累計成本-制费二 */
pjdb039       number(20,6)      ,/* 前期累計成本-制费三 */
pjdb040       number(20,6)      ,/* 前期累計成本-制费四 */
pjdb041       number(20,6)      ,/* 前期累計成本-制费五 */
pjdb042       number(20,6)      ,/* 本期結轉成本-材料 */
pjdb043       number(20,6)      ,/* 本期結轉成本-人工 */
pjdb044       number(20,6)      ,/* 本期結轉成本-加工费 */
pjdb045       number(20,6)      ,/* 本期結轉成本-制费一 */
pjdb046       number(20,6)      ,/* 本期結轉成本-制费二 */
pjdb047       number(20,6)      ,/* 本期結轉成本-制费三 */
pjdb048       number(20,6)      ,/* 本期結轉成本-制费四 */
pjdb049       number(20,6)      ,/* 本期結轉成本-制费五 */
pjdb050       varchar2(20)      /* 出貨單號 */
);
alter table pjdb_t add constraint pjdb_pk primary key (pjdbent,pjdbdocno,pjdbseq) enable validate;

create unique index pjdb_pk on pjdb_t (pjdbent,pjdbdocno,pjdbseq);

grant select on pjdb_t to tiptop;
grant update on pjdb_t to tiptop;
grant delete on pjdb_t to tiptop;
grant insert on pjdb_t to tiptop;

exit;
