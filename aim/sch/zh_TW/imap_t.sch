/* 
================================================================================
檔案代號:imap_t
檔案名稱:料件生命週期變更記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imap_t
(
imapent       number(5)      ,/* 企業編號 */
imapsite       varchar2(10)      ,/* 營運據點 */
imapseq       number(10,0)      ,/* 變更序 */
imap001       varchar2(40)      ,/* 料件編號 */
imap002       varchar2(10)      ,/* 原生命周期 */
imap003       varchar2(10)      ,/* 新生命周期 */
imap004       varchar2(10)      ,/* 變更作業 */
imap005       varchar2(20)      ,/* 變更單號 */
imap006       varchar2(20)      ,/* 變更人員 */
imap007       date      ,/* 變更日期 */
imap008       timestamp(0)      ,/* 變更時間 */
imapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imap_t add constraint imap_pk primary key (imapent,imapseq,imap001) enable validate;

create unique index imap_pk on imap_t (imapent,imapseq,imap001);

grant select on imap_t to tiptop;
grant update on imap_t to tiptop;
grant delete on imap_t to tiptop;
grant insert on imap_t to tiptop;

exit;
