/* 
================================================================================
檔案代號:xmeu_t
檔案名稱:銷售估價範本製程明細單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmeu_t
(
xmeuent       number(5)      ,/* 企業編號 */
xmeusite       varchar2(10)      ,/* 營運據點 */
xmeudocno       varchar2(20)      ,/* 範本料號 */
xmeu001       number(5,0)      ,/* 版次 */
xmeu002       varchar2(10)      ,/* 部位編號 */
xmeu003       varchar2(40)      ,/* 料件編號 */
xmeu004       varchar2(10)      ,/* 製程項序 */
xmeu005       varchar2(10)      ,/* 作業編號 */
xmeu006       varchar2(10)      ,/* 作業序 */
xmeu007       varchar2(10)      ,/* 工作站編號 */
xmeu008       number(15,3)      ,/* 預估工時 */
xmeu009       number(15,3)      ,/* 預估機時 */
xmeu010       varchar2(10)      ,/* 工作單位 */
xmeu011       varchar2(255)      ,/* 備註 */
xmeuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmeuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmeuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmeuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmeuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmeuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmeuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmeuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmeuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmeuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmeuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmeuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmeuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmeuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmeuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmeuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmeuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmeuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmeuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmeuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmeuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmeuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmeuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmeuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmeuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmeuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmeuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmeuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmeuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmeuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmeu_t add constraint xmeu_pk primary key (xmeuent,xmeusite,xmeudocno,xmeu001,xmeu002,xmeu003,xmeu004,xmeu005,xmeu006) enable validate;

create unique index xmeu_pk on xmeu_t (xmeuent,xmeusite,xmeudocno,xmeu001,xmeu002,xmeu003,xmeu004,xmeu005,xmeu006);

grant select on xmeu_t to tiptop;
grant update on xmeu_t to tiptop;
grant delete on xmeu_t to tiptop;
grant insert on xmeu_t to tiptop;

exit;
