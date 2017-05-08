/* 
================================================================================
檔案代號:xmey_t
檔案名稱:銷售估價其他費用單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xmey_t
(
xmeyent       number(5)      ,/* 企業編號 */
xmeysite       varchar2(10)      ,/* 營運據點 */
xmeydocno       varchar2(20)      ,/* 估價單號 */
xmeyseq       number(10,0)      ,/* 項次 */
xmey001       varchar2(10)      ,/* 內含外加 */
xmey002       varchar2(10)      ,/* 費用類型 */
xmey003       number(20,6)      ,/* 費用金額 */
xmeyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmeyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmeyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmeyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmeyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmeyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmeyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmeyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmeyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmeyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmeyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmeyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmeyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmeyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmeyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmeyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmeyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmeyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmeyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmeyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmeyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmeyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmeyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmeyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmeyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmeyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmeyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmeyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmeyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmeyud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmey004       varchar2(40)      ,/* 費用料號 */
xmey005       varchar2(10)      ,/* 幣別 */
xmey006       number(20,10)      ,/* 匯率 */
xmey007       number(20,6)      ,/* 預估金額 */
xmey008       varchar2(10)      ,/* 建議廠商 */
xmey009       varchar2(255)      /* 備註 */
);
alter table xmey_t add constraint xmey_pk primary key (xmeyent,xmeydocno,xmeyseq) enable validate;

create unique index xmey_pk on xmey_t (xmeyent,xmeydocno,xmeyseq);

grant select on xmey_t to tiptop;
grant update on xmey_t to tiptop;
grant delete on xmey_t to tiptop;
grant insert on xmey_t to tiptop;

exit;
