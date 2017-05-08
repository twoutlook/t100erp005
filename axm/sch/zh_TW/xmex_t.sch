/* 
================================================================================
檔案代號:xmex_t
檔案名稱:銷售估價製程明細單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmex_t
(
xmexent       number(5)      ,/* 企業編號 */
xmexsite       varchar2(10)      ,/* 營運據點 */
xmexdocno       varchar2(20)      ,/* 估價單號 */
xmexseq       number(10,0)      ,/* 製程項次 */
xmex001       varchar2(10)      ,/* 部位編號 */
xmex002       varchar2(40)      ,/* 料件編號 */
xmex003       varchar2(10)      ,/* 製程項序 */
xmex004       varchar2(10)      ,/* 作業編號 */
xmex005       varchar2(10)      ,/* 作業序 */
xmex006       varchar2(10)      ,/* 工作站編號 */
xmex007       number(15,3)      ,/* 預估工時 */
xmex008       number(15,3)      ,/* 預估機時 */
xmex009       varchar2(1)      ,/* 工作單位 */
xmex010       number(20,6)      ,/* 單位工資率 */
xmex011       number(20,6)      ,/* 單位製費率 */
xmex012       number(20,6)      ,/* 工資單價 */
xmex013       number(20,6)      ,/* 費用單價 */
xmex014       varchar2(255)      ,/* 備註 */
xmexud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmexud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmexud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmexud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmexud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmexud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmexud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmexud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmexud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmexud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmexud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmexud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmexud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmexud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmexud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmexud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmexud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmexud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmexud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmexud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmexud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmexud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmexud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmexud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmexud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmexud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmexud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmexud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmexud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmexud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmex_t add constraint xmex_pk primary key (xmexent,xmexdocno,xmexseq) enable validate;

create unique index xmex_pk on xmex_t (xmexent,xmexdocno,xmexseq);

grant select on xmex_t to tiptop;
grant update on xmex_t to tiptop;
grant delete on xmex_t to tiptop;
grant insert on xmex_t to tiptop;

exit;
