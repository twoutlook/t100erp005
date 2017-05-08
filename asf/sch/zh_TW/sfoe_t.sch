/* 
================================================================================
檔案代號:sfoe_t
檔案名稱:工單製程變更歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sfoe_t
(
sfoeent       number(5)      ,/* 企業代碼 */
sfoesite       varchar2(10)      ,/* 營運據點 */
sfoedocno       varchar2(20)      ,/* 工單單號 */
sfoeseq       number(10,0)      ,/* Run Card */
sfoeseq1       number(10,0)      ,/* 項次 */
sfoeseq2       number(10,0)      ,/* 項序 */
sfoe001       number(10,0)      ,/* 變更序 */
sfoe002       varchar2(20)      ,/* 變更欄位 */
sfoe003       varchar2(10)      ,/* 變更類型 */
sfoe004       varchar2(255)      ,/* 變更前內容 */
sfoe005       varchar2(255)      ,/* 變更后內容 */
sfoe006       varchar2(80)      ,/* 最後變更時間 */
sfoe007       varchar2(500)      ,/* 欄位說明SQL */
sfoeownid       varchar2(20)      ,/* 資料所有者 */
sfoeowndp       varchar2(10)      ,/* 資料所屬部門 */
sfoecrtid       varchar2(20)      ,/* 資料建立者 */
sfoecrtdp       varchar2(10)      ,/* 資料建立部門 */
sfoecrtdt       timestamp(0)      ,/* 資料創建日 */
sfoemodid       varchar2(20)      ,/* 資料修改者 */
sfoemoddt       timestamp(0)      ,/* 最近修改日 */
sfoecnfid       varchar2(20)      ,/* 資料確認者 */
sfoecnfdt       timestamp(0)      ,/* 資料確認日 */
sfoepstid       varchar2(20)      ,/* 資料過帳者 */
sfoepstdt       timestamp(0)      ,/* 資料過帳日 */
sfoestus       varchar2(10)      ,/* 狀態碼 */
sfoeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfoeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfoeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfoeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfoeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfoeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfoeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfoeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfoeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfoeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfoeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfoeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfoeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfoeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfoeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfoeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfoeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfoeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfoeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfoeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfoeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfoeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfoeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfoeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfoeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfoeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfoeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfoeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfoeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfoeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfoe_t add constraint sfoe_pk primary key (sfoeent,sfoedocno,sfoeseq,sfoeseq1,sfoeseq2,sfoe001,sfoe002) enable validate;

create unique index sfoe_pk on sfoe_t (sfoeent,sfoedocno,sfoeseq,sfoeseq1,sfoeseq2,sfoe001,sfoe002);

grant select on sfoe_t to tiptop;
grant update on sfoe_t to tiptop;
grant delete on sfoe_t to tiptop;
grant insert on sfoe_t to tiptop;

exit;
