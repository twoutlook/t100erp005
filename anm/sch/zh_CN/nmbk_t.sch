/* 
================================================================================
檔案代號:nmbk_t
檔案名稱:資金計劃日期明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table nmbk_t
(
nmbkent       number(5)      ,/* 企業編號 */
nmbkdocno       varchar2(20)      ,/* 資金計劃單號 */
nmbkseq       number(10,0)      ,/* 序號 */
nmbk001       date      ,/* 計劃編製日期 */
nmbk002       number(20,6)      ,/* 初編金額 */
nmbk003       number(20,6)      ,/* 變更後金額 */
nmbk004       number(20,6)      ,/* 審批金額 */
nmbk005       date      ,/* 實際生效日期 */
nmbk006       date      ,/* 實際失效日期 */
nmbk007       number(20,6)      ,/* 最後異動金額 */
nmbkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbk_t add constraint nmbk_pk primary key (nmbkent,nmbkdocno,nmbkseq,nmbk001) enable validate;

create unique index nmbk_pk on nmbk_t (nmbkent,nmbkdocno,nmbkseq,nmbk001);

grant select on nmbk_t to tiptop;
grant update on nmbk_t to tiptop;
grant delete on nmbk_t to tiptop;
grant insert on nmbk_t to tiptop;

exit;
