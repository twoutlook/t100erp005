/* 
================================================================================
檔案代號:xmfm_t
檔案名稱:銷售折扣合約分段計價檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfm_t
(
xmfment       number(5)      ,/* 企業編號 */
xmfmsite       varchar2(10)      ,/* 營運據點 */
xmfmdocno       varchar2(20)      ,/* 合約單號 */
xmfmseq       number(10,0)      ,/* 項次 */
xmfm001       number(20,6)      ,/* 起始數量/金額 */
xmfm002       number(20,6)      ,/* 截止數量/金額 */
xmfm003       number(20,6)      ,/* 折扣單價 */
xmfm004       number(20,6)      ,/* 折扣率 */
xmfmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfm_t add constraint xmfm_pk primary key (xmfment,xmfmdocno,xmfmseq,xmfm001,xmfm002) enable validate;

create unique index xmfm_pk on xmfm_t (xmfment,xmfmdocno,xmfmseq,xmfm001,xmfm002);

grant select on xmfm_t to tiptop;
grant update on xmfm_t to tiptop;
grant delete on xmfm_t to tiptop;
grant insert on xmfm_t to tiptop;

exit;
