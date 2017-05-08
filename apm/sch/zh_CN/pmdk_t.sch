/* 
================================================================================
檔案代號:pmdk_t
檔案名稱:核價分量計價檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdk_t
(
pmdkent       number(5)      ,/* 企業編號 */
pmdksite       varchar2(10)      ,/* 營運據點 */
pmdkdocno       varchar2(20)      ,/* 核價單號 */
pmdkseq       number(10,0)      ,/* 項次 */
pmdk001       number(20,6)      ,/* 起始數量 */
pmdk002       number(20,6)      ,/* 截止數量 */
pmdk003       number(20,6)      ,/* 單價 */
pmdk004       number(20,6)      ,/* 折扣率 */
pmdkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmdk_t add constraint pmdk_pk primary key (pmdkent,pmdkdocno,pmdkseq,pmdk001,pmdk002) enable validate;

create unique index pmdk_pk on pmdk_t (pmdkent,pmdkdocno,pmdkseq,pmdk001,pmdk002);

grant select on pmdk_t to tiptop;
grant update on pmdk_t to tiptop;
grant delete on pmdk_t to tiptop;
grant insert on pmdk_t to tiptop;

exit;
