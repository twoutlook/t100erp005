/* 
================================================================================
檔案代號:pmbk_t
檔案名稱:供應商評核公式基本資料檔(製造)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmbk_t
(
pmbkent       number(5)      ,/* 企業編號 */
pmbksite       varchar2(10)      ,/* 營運據點 */
pmbk001       varchar2(10)      ,/* 供應商評核公式編號 */
pmbk002       varchar2(255)      ,/* 說明 */
pmbk003       number(10,0)      ,/* 評核週期(月) */
pmbk004       number(5,0)      ,/* 最近評核年度 */
pmbk005       number(5,0)      ,/* 最近評核月份 */
pmbk006       date      ,/* 生效日期 */
pmbk007       date      ,/* 失效日期 */
pmbk008       number(20,6)      ,/* 定量評核整體權重 */
pmbk009       number(20,6)      ,/* 定性評核整體權重 */
pmbkownid       varchar2(20)      ,/* 資料所有者 */
pmbkowndp       varchar2(10)      ,/* 資料所屬部門 */
pmbkcrtid       varchar2(20)      ,/* 資料建立者 */
pmbkcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmbkcrtdt       timestamp(0)      ,/* 資料創建日 */
pmbkmodid       varchar2(20)      ,/* 資料修改者 */
pmbkmoddt       timestamp(0)      ,/* 最近修改日 */
pmbkstus       varchar2(10)      ,/* 狀態碼 */
pmbkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbk_t add constraint pmbk_pk primary key (pmbkent,pmbksite,pmbk001) enable validate;

create unique index pmbk_pk on pmbk_t (pmbkent,pmbksite,pmbk001);

grant select on pmbk_t to tiptop;
grant update on pmbk_t to tiptop;
grant delete on pmbk_t to tiptop;
grant insert on pmbk_t to tiptop;

exit;
