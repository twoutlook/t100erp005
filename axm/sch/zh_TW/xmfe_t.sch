/* 
================================================================================
檔案代號:xmfe_t
檔案名稱:銷售報價費用資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfe_t
(
xmfeent       number(5)      ,/* 企業編號 */
xmfesite       varchar2(10)      ,/* 營運據點 */
xmfedocno       varchar2(20)      ,/* 估價單號 */
xmfeseq       number(10,0)      ,/* 項次 */
xmfe001       varchar2(10)      ,/* 內含外加 */
xmfe002       varchar2(10)      ,/* 費用類型 */
xmfe003       varchar2(10)      ,/* 計算基礎 */
xmfe004       number(20,6)      ,/* 加乘基數 */
xmfe005       number(20,6)      ,/* 預估金額 */
xmfeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfe_t add constraint xmfe_pk primary key (xmfeent,xmfedocno,xmfeseq) enable validate;

create unique index xmfe_pk on xmfe_t (xmfeent,xmfedocno,xmfeseq);

grant select on xmfe_t to tiptop;
grant update on xmfe_t to tiptop;
grant delete on xmfe_t to tiptop;
grant insert on xmfe_t to tiptop;

exit;
