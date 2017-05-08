/* 
================================================================================
檔案代號:fabk_t
檔案名稱:資產外送/收回單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabk_t
(
fabkent       number(5)      ,/* 企業編號 */
fabkcomp       varchar2(10)      ,/* 法人 */
fabkdocno       varchar2(20)      ,/* 單據編號 */
fabkseq       number(10,0)      ,/* 項次 */
fabk000       varchar2(10)      ,/* 卡片編號 */
fabk001       varchar2(20)      ,/* 財產編號 */
fabk002       varchar2(20)      ,/* 附號 */
fabk003       varchar2(10)      ,/* 單位 */
fabk004       number(10,0)      ,/* 數量 */
fabk005       number(10,0)      ,/* 在外數量 */
fabk006       number(10,0)      ,/* 外送數量/收回數量 */
fabk007       varchar2(40)      ,/* 外送地點 */
fabk008       varchar2(10)      ,/* 原因 */
fabk009       number(10)      ,/* 資產狀態 */
fabkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabk_t add constraint fabk_pk primary key (fabkent,fabkdocno,fabkseq) enable validate;

create unique index fabk_pk on fabk_t (fabkent,fabkdocno,fabkseq);

grant select on fabk_t to tiptop;
grant update on fabk_t to tiptop;
grant delete on fabk_t to tiptop;
grant insert on fabk_t to tiptop;

exit;
