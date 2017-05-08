/* 
================================================================================
檔案代號:inpn_t
檔案名稱:週期盤點限定產品分類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inpn_t
(
inpnent       number(5)      ,/* 企業編號 */
inpnsite       varchar2(10)      ,/* 營運據點 */
inpndocno       varchar2(20)      ,/* 計劃單號 */
inpnseq       number(10,0)      ,/* 項次 */
inpn001       varchar2(10)      ,/* 產品分類 */
inpn002       varchar2(255)      ,/* 備註 */
inpnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpn_t add constraint inpn_pk primary key (inpnent,inpnsite,inpndocno,inpnseq) enable validate;

create unique index inpn_pk on inpn_t (inpnent,inpnsite,inpndocno,inpnseq);

grant select on inpn_t to tiptop;
grant update on inpn_t to tiptop;
grant delete on inpn_t to tiptop;
grant insert on inpn_t to tiptop;

exit;
