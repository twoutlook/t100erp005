/* 
================================================================================
檔案代號:xcbk_t
檔案名稱:每月工單人工制費檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcbk_t
(
xcbkent       number(5)      ,/* 企業編號 */
xcbkld       varchar2(5)      ,/* 帳別編號 */
xcbkcomp       varchar2(10)      ,/* 法人組織 */
xcbk001       varchar2(10)      ,/* 成本計算類型 */
xcbk002       number(5,0)      ,/* 年度 */
xcbk003       number(5,0)      ,/* 期別 */
xcbk004       varchar2(10)      ,/* 成本中心 */
xcbk005       varchar2(1)      ,/* 費用分類(成本主要素) */
xcbk006       varchar2(20)      ,/* 工單編號 */
xcbk007       varchar2(1)      ,/* 分攤方式 */
xcbk100       number(20,6)      ,/* 工單分攤數 */
xcbk101       number(20,6)      ,/* 單位成本(本位幣一) */
xcbk111       number(20,6)      ,/* 單位成本(本位幣二) */
xcbk121       number(20,6)      ,/* 單位成本(本位幣三) */
xcbk202       number(20,6)      ,/* 分攤金額(本位幣一) */
xcbk212       number(20,6)      ,/* 分攤金額(本位幣二) */
xcbk222       number(20,6)      ,/* 分攤金額(本位幣三) */
xcbkownid       varchar2(20)      ,/* 資料所有者 */
xcbkowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbkcrtid       varchar2(20)      ,/* 資料建立者 */
xcbkcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbkcrtdt       timestamp(0)      ,/* 資料創建日 */
xcbkmodid       varchar2(20)      ,/* 資料修改者 */
xcbkmoddt       timestamp(0)      ,/* 最近修改日 */
xcbkstus       varchar2(10)      ,/* 狀態碼 */
xcbkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbk_t add constraint xcbk_pk primary key (xcbkent,xcbkld,xcbk001,xcbk002,xcbk003,xcbk004,xcbk005,xcbk006,xcbk007) enable validate;

create unique index xcbk_pk on xcbk_t (xcbkent,xcbkld,xcbk001,xcbk002,xcbk003,xcbk004,xcbk005,xcbk006,xcbk007);

grant select on xcbk_t to tiptop;
grant update on xcbk_t to tiptop;
grant delete on xcbk_t to tiptop;
grant insert on xcbk_t to tiptop;

exit;
