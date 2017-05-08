/* 
================================================================================
檔案代號:xmds_t
檔案名稱:訂單費用資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmds_t
(
xmdsent       number(5)      ,/* 企業編號 */
xmdssite       varchar2(10)      ,/* 營運據點 */
xmdsdocno       varchar2(20)      ,/* 估價單號 */
xmdsseq       number(10,0)      ,/* 項次 */
xmds001       varchar2(40)      ,/* 費用料號 */
xmds002       varchar2(10)      ,/* 幣別 */
xmds003       number(20,10)      ,/* 匯率 */
xmds004       number(20,6)      ,/* 預估金額 */
xmds005       varchar2(10)      ,/* 建議廠商 */
xmds006       varchar2(255)      ,/* 備註 */
xmdsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmds_t add constraint xmds_pk primary key (xmdsent,xmdsdocno,xmdsseq) enable validate;

create unique index xmds_pk on xmds_t (xmdsent,xmdsdocno,xmdsseq);

grant select on xmds_t to tiptop;
grant update on xmds_t to tiptop;
grant delete on xmds_t to tiptop;
grant insert on xmds_t to tiptop;

exit;
